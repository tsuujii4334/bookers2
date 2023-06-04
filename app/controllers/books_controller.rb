class BooksController < ApplicationController
  def new
    @book = Book.new #新しくbookレコードを取得 
  end
  
  
  #投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id) #@book.id(新しく取得したbookレコード)のbookshowページに飛ぶ
  end
  
  def index
    @user = User.find(params[:id])
    @book = Book.find(params[:id])
    @books = book.all
  end
  
  def show
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id]) #そのままidが適用される？
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
