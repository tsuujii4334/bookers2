class BooksController < ApplicationController

  def new
    @book = Book.new #新しくbookレコードを取得
  end


  #投稿データの保存
  def create
    @book = Book.new(book_params) #フォームで入力された記述を入れる。必要な記述
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id) #@book.id(新しく取得したbookレコード)のbookshowページに飛ぶ
    else
      @user = current_user
      @books = Book.all
      render :index   #同じコントローラー内だとシングルクォーテーションで囲む 
    end               #render :inidex =>index.htmlが直接出力されるイメージ
  end

  def index
    @user = current_user #ログインしてるuser
    @book = Book.new
    @books = Book.all
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
    if @user != @book.user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(params[:id])
    else
      render 'edit'
    end
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



  #def correct_user
  #  @book = Book.find(params[:id])
  #  @user = @book.user
  #  redirect_to(book_path(params[:id])) unless @user == current_user
  #end

end
