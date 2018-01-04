# FSA Ratings App

This repository contains the source code for a web app which gives to user the ability to choose froma list of local UK authorities and 
see a table which presents how the ratings for all establishments in an authority are distributed.

This app was created in response to a technical test I received a while ago. I took it on as a mini project.

I used the Sinatra DSL to handle requests and HTTParty to make calls to the FSA's API. When requesting a list of all authorities I could
easily use json parsing but when it came to handling data regarding a specific authority I had to use Nokogiri to parse xml.
