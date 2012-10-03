class Sidebar < ActiveRecord::Base
  attr_accessible :slug, :title, :widget_ids
  belongs_to :account
  has_many :widget_placements
  has_many :widgets, :through => :widget_placements
  has_many :pages

  accepts_nested_attributes_for :widgets
  
  validates_uniqueness_of :slug, :scope => :account_id
  
  
  
  def body(show_edit_controls = false)
    return nil if self.widgets.count == 0
    html = self.widgets.map do |widget|
      %Q{
         <div class="widget widget-slug-#{widget.slug}">
           <!--div class="widget-title"><h3>#{widget.title}</h3></div-->
           <div class="widget-body"#{widget.body}</div>
        
         </div>
       }
      
    end
    html.join('').to_s.html_safe
  end
  
end