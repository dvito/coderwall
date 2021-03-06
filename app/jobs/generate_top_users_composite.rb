class GenerateTopUsersComposite
  extend ResqueSupport::Basic

  IMAGE_PATH = Rails.root.join('public', 'images', 'top')
  WALL_IMAGE = IMAGE_PATH.join("wall.png")

  def perform
    cache_users
    cache_images
    composite_images
  end

  private

  def cache_users
    users = User.top(108).map { |u| {u.username => u.thumbnail_url} }.to_json
    REDIS.set "top_users", users
  end

  def cache_images
    IMAGE_PATH.mkpath

    users = JSON.parse(REDIS.get("top_users"))
    users.each.with_index do |pair, i|
      username, url = pair.keys.first, pair.values.first

      fname = IMAGE_PATH.join("#{i+1}.png")
      sh "curl -s #{url} | convert - -resize '65x65' #{fname}"
    end
  end

  def composite_images
    rows = 9.times.map do |row|
      start = (row * 12) + 1
      finish = start + 12

      columns = (start...finish).map { |col| IMAGE_PATH.join("#{col}.png") }

      IMAGE_PATH.join("row#{row + 1}.png").tap do |image|
        sh "convert #{columns.join(' ')} +append '#{image}'"
      end
    end

    sh "convert #{rows.join(' ')} -append '#{WALL_IMAGE}'"
  end

  def sh(command)
    system command
  end

end
