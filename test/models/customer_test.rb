require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # Must pass everything
  # rails test:models
  
  def setup
    @customer = Customer.new(username: "Test Customer", email: "customer@myapp.com",
                            password: "test12345", password_confirmation: "test12345")
  end
  
  test "Customer Validity Check" do
    assert @customer.valid?
  end
  
  test "Name must exist" do
    @customer.username = " "
    assert_not @customer.valid?
  end
  
  test "Email must exist" do
    @customer.email = " "
    assert_not @customer.valid?
  end
  
  test "Username length check" do
    @customer.username = "X" * 20
    assert_not @customer.valid?
  end
  
  test "Email length check" do
    @customer.email = "X" * 100 + "@example.com"
    assert_not @customer.valid?
  end
 
  test "Good email check" do
    # A list of valid emails
    valid_emails = "s5180158@student.rmit.edu.au", "CAPITAL@EMAIL.DOMAIN", "other_characters@email-check.com",
                    "mary.had@litte.lamb", "one+two@three.fo"
    valid_emails.each do |email|
      @customer.email = email
      assert @customer.valid?, "#{email.inspect} should be valid"
    end
 end
 
 test "Bad emails should be rejected" do
    invalid_emails = "s5180158@student,rmit.edu.au", "CAPITALEMAIL.DOMAIN", "other_characters@email-check.com5",
                    "mary.had@litte!.lamb", "one+two@at@three.fo"
    invalid_emails.each do | email |
        @customer.email = email
        assert_not @customer.valid?, "#{email.inspect} should be invalid"
    end
 end
 
  test "Email addresses cannot be duplicated" do
    clone = @customer.dup
    clone.email = @customer.email.upcase
    @customer.save
    assert_not clone.valid?
  end
   
  test "Password cannot be blank" do
     @customer.password = @customer.password_confirmation = " " * 6
     assert_not @customer.valid?
  end
  
  test "Password should be longer than 6 chars" do
    @customer.password = @customer.password_confirmation = "X" * 5
    assert_not @customer.valid?
  end
 
  #test "Is user authenticated? Will return false without cookies" do 
  #  assert_not @customer.authenticated?('') 
  #end
 
end
