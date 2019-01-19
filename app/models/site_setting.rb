class SiteSetting < ApplicationRecord
	def getvalue(item)
    SiteSetting.find_by(key: item)[:value]
  end
end
