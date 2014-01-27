namespace :generators do

	task :question_and_answers => :environment do

		number_of_questions = ENV['number_of_questions'] ? ENV['number_of_questions'].to_i : 50
		number_of_answers   = ENV['number_of_answers'] ? ENV['number_of_answers'].to_i : 10 #ENV['HOME']
		puts "Qs: #{number_of_questions} and As: #{number_of_answers}"
		number_of_questions.times do
			q=Question.create(title: Faker::Lorem.sentence(10), body: Faker::Lorem.sentence(20))
			number_of_answers.times do
				q.answers.create(body: Faker::Lorem.sentence(12))
			end
		end
	end
end