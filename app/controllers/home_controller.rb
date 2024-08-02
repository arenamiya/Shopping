class HomeController < ApplicationController

    def home
        @subscription = Subscription.new
        @item = Collection.order('RANDOM()').first
    end

    def new_item
        @subscription = Subscription.new
        @item = Collection.order('RANDOM()').first
        print "new item = " + @item.name
        render :home
    end
end
