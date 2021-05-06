module LogInCorporation
  
  def log_in(corporation)
    # トップページにいく
    visit root_path
    # ログインボタンがある
    expect(page).to have_content('企業様ログイン')
    # ログインページにいく
    visit new_corporation_session_path

    # ログイン情報を入力する
      fill_in 'corporation[email]', with: 'c@1.com'
      fill_in 'corporation[password]', with: 'corpor'
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページに移行する
    expect(current_path).to eq (root_path)
    # ログアウトボタンが表示される。新規登録・ログインボタンは表示されない。
    expect(page).to have_content ('ログアウト')
    expect(page).to have_no_content ('企業様ログイン')

  end
end