ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
end
