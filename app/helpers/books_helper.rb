module BooksHelper
  def check_controller(controller)
    unless controller == 'sessions' || controller == 'registrations'
      return true
    end
  end

  def is_registered(user_id, book_id)
    user = User.find(user_id)
    book = Book.where(book_id: book_id).first
    res = user.shelves.where(book_id: book.id)

    res.any?
  end
end
