class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :username, :password_hash, { presence: true }

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password_string)
    self.password == password_string
  end
end
