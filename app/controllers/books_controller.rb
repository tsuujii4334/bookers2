class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  
  #投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path
  end
  
  def index
    @user = User.find(current_user)
    @book = Book.find(params[:id])
    @books = book.all
    
  end
  
  def show
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  #投稿データのストロングパラメータ
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

  
end
