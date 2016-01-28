def setup_connection!
  name = "xpg_#{SecureRandom.hex}"

  File.popen('psql', 'w') do |psql|
    psql.write(<<-SQL)
      CREATE DATABASE #{name}
    SQL
  end

  ActiveRecord::Base.establish_connection adapter: :postgresql,
                                          database: name
  name
end

def close_connection!(name)
  ActiveRecord::Base.remove_connection
  File.popen('psql', 'w') do |psql|
    psql.write(<<-SQL)
      DROP DATABASE #{name};
    SQL
  end
end
