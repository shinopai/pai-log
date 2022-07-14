class BooksController < ApplicationController
  require 'net/http'
  require 'uri'

  BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q='
  BASE_URL.freeze

  def search
    q = URI.encode_www_form(q: params[:search_word])
    search_url = BASE_URL + q

    @result = JSON.parse(Net::HTTP.get(URI.parse(
      search_url
    )))
    # render plain: @result['items'].inspect
    respond_to do |format|
      format.html
      format.json { render :json => @result }
    end
  end

  def show
    q = URI.encode_www_form(q: params[:title])
    q2 = URI.encode_www_form(q2: params[:author][0])
    res_q = q[2..q.size]
    res_q2 = q2[3..q2.size]

    search_url = BASE_URL + 'intitle:' + res_q
    search_url += '+inauthor:' + res_q2
    @item = JSON.parse(Net::HTTP.get(URI.parse(
      search_url
    )))

    # booksテーブルに登録されて無い場合に登録する
    res = Book.where(book_id: @item['items'][0]['id']).first

    if res.nil?
      Book.create([
        'book_id' => @item['items'][0]['id'],
        'title' => @item['items'][0]['volumeInfo']['title'],
        'author' => @item['items'][0]['volumeInfo']['authors'][0],
        'description' => @item['items'][1]['volumeInfo']['description'],
        'publisher' => @item['items'][1]['volumeInfo']['publisher'],
        'publish_date' => @item['items'][1]['volumeInfo']['publishedDate'],
        'image' => @item['items'][0]['volumeInfo']['imageLinks']['thumbnail']
      ])
    end

    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def add_item
    user = User.find(params[:id])
    book = Book.where(book_id: params[:book_id])
    user.books << book

    redirect_to request.referer
  end
end
