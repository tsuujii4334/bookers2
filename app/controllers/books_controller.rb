class BooksController < ApplicationController
  def new
    @book = Book.new #新しくbookレコードを取得
  end


  #投稿データの保存
  def create
    @book = Book.new(book_params) #フォームで入力された記述を入れる。必要な記述
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id) #@book.id(新しく取得したbookレコード)のbookshowページに飛ぶ
  end

  def index
    @user = current_user #ログインしてるuser
    @book = Book.new
    @books = Book.all
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
  end

  def edit
    @book = Book.find(params[:id]) #urlが適用される
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  #投稿データのストロングパラメータ
  private

  def book_params #フォームで入力された内容についての記述
    params.require(:book).permit(:title, :body) #基本この形　params.require(:カラム名).permit(:title, :bodyなど)
  end


end
