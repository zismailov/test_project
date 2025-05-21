puts "Очищаем базу данных..."
Foo.destroy_all

puts "Создаем тестовые данные..."

5.times do |i|
  foo = Foo.create!(
    name: "Foo #{i + 1}"
  )

  rand(3..5).times do |j|
    foo.bars.create!(
      name: "Bar #{j + 1} для Foo #{i + 1}",
      description: "Описание Bar #{j + 1} для Foo #{i + 1}"
    )
  end

  puts "Создан Foo #{i + 1} с #{foo.bars.count} Bar"
end

puts "- #{Foo.count} Foo"
puts "- #{Bar.count} Bar"