class Vacancy < ActiveRecord::Base
  include AASM

  belongs_to :category
  belongs_to :staff
  belongs_to :client
  has_and_belongs_to_many :candidates, :join_table => :applications

  validates_presence_of \
  :role,
  :salary,
  :location,
  :role_description

  validates_presence_of :staff_id, :unless => Proc.new { |v| v.status == "draft" }

  aasm_column :status
  aasm_initial_state :draft

  aasm_state :draft
  aasm_state :awaiting_approval
  aasm_state :live
  aasm_state :archived

  aasm_event :submit_for_approval do
    transitions :to => :awaiting_approval, :from => [:draft]
  end

  aasm_event :approve do
    transitions :to => :live, :from => :awaiting_approval
  end

  aasm_event :archive do
    transitions :to => :archived, :from => :live
  end

  def self.find_by_owner_and_status(client_id, status)
    belonging_to(client_id).with_status(status)
  end

  def editor_ids
    ug = UserGroup.find_by_name("Staffs")
    ug.user_ids |= [self.client_id]
  end

  def to_s
    role
  end


  private

  named_scope :belonging_to, lambda { |owner_id|
    { :conditions => { :client_id => owner_id } }
  }
  named_scope :with_status, lambda { |state|
    { :conditions => { :status => state } }
  }
  named_scope :with_category, lambda { |cat|
    { :conditions => { :category_id => Category.find_by_name(cat).id } }
  }

  def is_draft?
    status == "draft"
  end


end
