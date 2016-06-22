class Record < ActiveRecord::Base
  validates_presence_of :title, :date, :amount
end
