class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @word_count = @text.split.length

    @character_count_with_spaces = @text.length

text_wo_spaces = @text.gsub(" ","")
text_wo_linefeed = text_wo_spaces.gsub("\n","")
text_wo_cr = text_wo_linefeed.gsub("\r","")
text_wo_tabs = text_wo_cr.gsub("\t","")
    @character_count_without_spaces = text_wo_tabs.length

lowercase_text = @text.downcase
        lowercase_text_wo_punc=lowercase_text.gsub(/[^a-z0-9\s]/i," ")
        split_lowercase_text = lowercase_text_wo_punc.split
        lowercase_special_word = @special_word.downcase
        @occurrences = split_lowercase_text.count(lowercase_special_word)
    @occurrences = @text.split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
@real_apr = @apr/100
@monthly_apr = @real_apr/12
@periods = @years*12
@monthly_payment = @principal*((@monthly_apr)*((1+@monthly_apr)**@periods)/((1+@monthly_apr)**@periods)-1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @sorted_numbers.count

    @minimum = @sorted_numbers.min

    @maximum = @sorted_numbers.max

    @range = @maximum-@minimum

@median = ((@sorted_numbers[(@count-1)/2])+(@sorted_numbers[(@count+1)/2])/2)

    @sum = @numbers.sum

    @mean = @sum/@count

    @variance = @numbers.inject(0.0) {|s,x| s + (x - @mean)**2} / @count

    @standard_deviation = @variance**0.5

    @frequency = freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode= @numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
