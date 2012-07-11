class Ticket < ActiveRecord::Base
  
  belongs_to :event
  belongs_to :area
  
  attr_accessible :price, :state
  
  attr_accessor :label, :area_label, :area_type, :service_charge
  # attr_accessor :status
  
  def label
    "Seat #{self.id}"
  end
  
  def area_label
    self.area.label_section
  end
  
  def area_type
    self.area.type
  end
  
  def service_charge
    3.00
  end
  
  def status # dynamic property -- either state or locked
    @ticket_lock = TicketLock.new(:ticket_id => self.id)
    
    if @ticket_lock.is_locked?
      status = 'locked'
    else
      status = self.state
    end
    status
  end
end