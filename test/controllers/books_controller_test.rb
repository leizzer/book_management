require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get books_url, as: :json
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count") do
      post books_url, params: { book: { title: @book.title } }, as: :json
    end

    assert_response :created
  end

  test "should show book" do
    get book_url(@book), as: :json
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { title: @book.title } }, as: :json
    assert_response :success
  end

  test "should reserve book" do
    book = Book.create(title: "Test Book")
    assert_difference("Reservation.count") do
      post reserve_book_url(book), params: {email: "chuck@mail.com"}, as: :json
    end

    assert_response :success
  end
end
