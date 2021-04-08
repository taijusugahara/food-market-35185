Corporation.find_or_create_by(id: 1) do |cor|
  cor.email = 'corporation@1.com'
  cor.password = 'corporation'
end

food = Category.create(name: "食品")
vegetable = food.children.create(name: "野菜")
meat = food.children.create(name: "肉")
vegetable.children.create([{name: "トマト"}, {name: "キャベツ"}])