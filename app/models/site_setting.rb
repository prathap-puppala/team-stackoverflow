# frozen_string_literal: true

# This class contains SiteSetting related functions
class SiteSetting < ApplicationRecord
  def self.getvalue(item)
    find_by(key: item)[:value]
  end
end
