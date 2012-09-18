# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  slug       :string(255)      not null
#  title      :string(255)      not null
#  body       :text
#  account_id :integer
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title
  belongs_to :account
  belongs_to :parent, :class_name => 'Page'
  has_many :children, :class_name => 'Page', :foreign_key => 'parent_id'
  
  validates_uniqueness_of :slug, :scope => :account_id
  
end