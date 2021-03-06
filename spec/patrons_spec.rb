require("rspec")
require("pg")
require("patrons")
require("spec_helper")


  describe(Patron) do
    describe(".all") do
      it("starts off with no patrons") do
        expect(Patron.all()).to(eq([]))
    end
  end

  describe("#name") do
  it("tells you its name") do
    patron = Patron.new({:name => "Chris", :id => nil})
    expect(patron.name()).to(eq("Chris"))
  end
end

  describe("#id") do
    it("sets its patron ID when you save it") do
      patron = Patron.new({:name => "Maly", :id => nil})
      patron.save()
      expect(patron.id()).to(be_an_instance_of(Integer))
    end
  end

  describe("#save") do
    it("lets you save patron to the database") do
      patron = Patron.new({:name => "Treasure Island", :id => nil})
      patron.save()
      expect(Patron.all()).to(eq([patron]))
    end
  end

  describe("#==") do
      it("is the same patron if it has the same name") do
        patron1 = Patron.new({:name => "Epicodus", :id => nil})
        patron2 = Patron.new({:name => "Epicodus", :id => nil})
        expect(patron1).to(eq(patron2))
      end
    end

    describe(".find") do
    it("returns a patron by its ID") do
      patron = Patron.new({:name => "Joe", :id => nil})
      patron.save()
      patron2 = Patron.new({:name => "Chris", :id => nil})
      patron2.save()
      expect(Patron.find(patron2.id())).to(eq(patron2))
    end
  end

  describe("#update") do
    it("lets you update patrons in the database") do
      patron = Patron.new({:name => "Guy", :id => nil})
      patron.save()
      patron.update({:name => "Steve"})
      expect(patron.name()).to(eq("Steve"))
    end
    it("lets you add a book to the patron") do
      patron = Patron.new({:name => "Guy", :id => nil})
      patron.save()
      book = Book.new({:title => "Green Eggs", :id => nil})
      book.save()
      book2 = Book.new({:title => "A Tale of Two Cities", :id => nil})
      book2.save()
      patron.update({:book_ids => [book.id(), book2.id()]})
      expect(patron.books()).to(eq([book, book2]))

    end
  end

  describe("#delete") do
    it("lets you delete a patron from the database") do
      patron1 = Patron.new({:name => "Maly", :id => nil})
      patron1.save()
      patron2 = Patron.new({:name => "Chris", :id => nil})
      patron2.save()
      patron2.delete()
      expect(Patron.all()).to(eq([patron1]))
    end
  end


end
