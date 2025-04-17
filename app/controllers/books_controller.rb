class BooksController < ApplicationController
  before_action :set_book, only: %i[ show update destroy reserve ]

  rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors

  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy!
  end

  def reserve
    @book.reserve!(reservation_params)
    render json: @book
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.expect(book: [ :title ])
    end

    def reservation_params
      params.expect(:email)
    end

    def show_record_errors(exception)
      render json: @book.errors, status: :unprocessable_entity
    end
end
