#primary author: Isabella
require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  def test_debtors_returned
    #if add member to invoice then add invoice to group_purchase
    # group_purchase.debtors should display correctly
    kwhite17 = members(:kwhite17)
    group_purchase1 = group_purchases(:one)
    debtors_expected = Array.new

    invoice1 = invoices(:one)
    invoice1.debtor = kwhite17
    invoice1.group_purchase = group_purchase1
    invoice1.save

    debtors_expected.push(kwhite17)

    assert_equal group_purchase1.debtors, debtors_expected, "Test that debtors are returned correctly"

  end

  def test_member_typeahead
    #test creator not in result
    kwhite17 = members(:kwhite17)
    group_purchase1 = group_purchases(:one)
    result_expected1 = Array.new
    result_expected1.push({:status=>"creditor"})
    group_purchase1.creditor = kwhite17
    members1 = Member.retreive_typeahead_members('k', group_purchase1)
    
    assert_equal members1 , result_expected1, "Creditor so doesn't appear"


    #test debtors not in result
    result_expected2 = Array.new
    result_expected2.push({:id=>756201275, :name=>"rene.miller3@gmail.com"})
    snaga = members(:snaga)
    group_purchase2 = group_purchases(:two)
    group_purchase2.creditor = kwhite17
    invoice1 = invoices(:one)
    invoice1.debtor = snaga
    invoice1.group_purchase = group_purchase2
    invoice1.save
    
    members2 = Member.retreive_typeahead_members('a', group_purchase2)
    assert_equal members2, result_expected2, "Debtors not in result"
    
    #test normal query correct
    members3 = Member.retreive_typeahead_members('a', group_purchase1)
    result_expected3 = Array.new
    result_expected3.push({:id=>756201275, :name=>"rene.miller3@gmail.com"})
    result_expected3.push({:id=>984998030, :name=>"snaga@mit.edu"})
    assert_equal members3, result_expected3, "Normal search passed"
  
  end

  def test_search
    #search with parameter 'a'
    members1 = Member.search('a').map { |m| {:id => m.id, :name => m.email } }
    result_expected1 = Array.new
    result_expected1.push({:id=>756201275, :name=>"rene.miller3@gmail.com"})
    result_expected1.push({:id=>984998030, :name=>"snaga@mit.edu"})
    assert_equal members1 , result_expected1, "Searching for nonempty query"

    #empty string returns all members
    members2 = Member.search('').map { |m| {:id => m.id, :name => m.email } }
    result_expected2 = Array.new
    result_expected2.push({:id=>625510808, :name=>"kwhite17@mit.edu"})
    result_expected2.push({:id=>756201275, :name=>"rene.miller3@gmail.com"})
    result_expected2.push({:id=>984998030, :name=>"snaga@mit.edu"})
    assert_equal members2, result_expected2 , "Seaching with empty query string"

    #no members returned
    members3 = Member.search('isabellatromba').map { |m| {:id => m.id, :name => m.email } }
    result_expected3 = Array.new
    assert_equal members3, result_expected3 , "Seaching with no results"
  end


end
