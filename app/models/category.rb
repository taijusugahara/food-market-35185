class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '野菜' },
    { id: 3, name: '肉' },
    { id: 4, name: '魚' },
    { id: 5, name: '果物' },
    { id: 6, name: '乳製品' },
    { id: 7, name: 'お菓子' },
    { id: 8, name: '惣菜' },
    { id: 9, name: '飲み物' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :items
end
