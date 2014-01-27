namespace :fill_ups do

	desc "Add Categories"
	task :add_categories => :environment do
		["Real Project","Fake Project","Construction","Accounting"].each do |cat|
			Category.create(name:cat)
		end

	end
end
