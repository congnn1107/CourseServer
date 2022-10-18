# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin = User.create({
                      name: "Admin",
                      email: "admin@admin.com",
                      password: "12345678",
                      date_of_birth: "1/1/1991",
                      is_admin: true,
                      is_active: true,
                    })
question_type = QuestionType.create({ name: "One Answer Test" })
