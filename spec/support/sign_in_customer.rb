module SignInCustomer
  def sign_in(customer)
    # トップページにいく
    visit root_path
    # ログインボタンがある
    expect(page).to have_content('お客様ログイン')
    # ログインページにいく
    visit new_customer_session_path

    # ログイン情報を入力する
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページに移行する
    expect(current_path).to eq(root_path)
    # ログアウトボタンが表示される。新規登録・ログインボタンは表示されない。
    expect(page).to have_content('ログアウト')
    expect(page).to have_no_content('お客様新規登録')
    expect(page).to have_no_content('お客様ログイン')
  end
end
