class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_protected :id, :salt, :last_login, :authorizations

  belongs_to :crew

  validates :username, :presence => true, :if => Proc.new { |p| !p.encrypted_password.blank?}
  validates :encrypted_password, :presence => true, :if => Proc.new { |p| !p.username.blank?}
  validates_confirmation_of :password
  validates_length_of :username, :within => 3..20, :allow_blank => true
  validates_length_of :password, :within => 7..30, :allow_blank => true
  validates_uniqueness_of :username, :allow_blank => false

  def authorizations=(arg)
    self[:authorizations] = arg if arg.class == String
    self[:authorizations] = arg.join(",") if arg.class == Array
  end

  def add_authorization(arg)
    if self[:authorizations].blank?
      self.authorizations = arg
    else
      self[:authorizations] += "," + arg if arg.class == String
      self[:authorizations] += "," + arg.join(",") if arg.class == Array
    end
    self.authorizations
  end

  def has_authorization?(*args)
    unless self[:authorizations].nil?
      authorizations = self[:authorizations].split(',').collect { |a| a.strip }
      args.each { |a| return true if authorizations.include?(a) }
    end
    return false
  end

  def is_admin?
    return true if self.account_type == "admin"
    return false
  end

  def password=(password)
    @password = password
    if @password.blank?
      self.encrypted_password = ""
    else
      self.salt = User.generate_salt if !self.salt
      self.encrypted_password = Digest::SHA1.hexdigest(self.salt + password)
    end
  end

  def remove_authorization(s)
    unless self.authorizations.nil?
      arr = self[:authorizations].split(/,/)
      arr.delete(s)
      self[:authorizations] = arr.join(",")
    end
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    if user.encrypted_password == Digest::SHA1.hexdigest(user.salt + password)
      return user
    end
    return nil
  end

  def to_xml(options = {})
    super(:except => [:salt, :encrypted_password])
  end

  protected

  def self.generate_salt
    return Digest::SHA1.hexdigest(Time.now.to_s)
  end
end
