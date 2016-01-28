def setup_connection!
  name = "xpg_#{SecureRandom.hex}"
  `createdb '#{name}'`

  ActiveRecord::Base.establish_connection adapter: :postgresql,
                                          database: name
  name
end

def close_connection!(name)
  ActiveRecord::Base.remove_connection
  `dropdb '#{name}'`
end
