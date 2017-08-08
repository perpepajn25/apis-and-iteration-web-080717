require 'rest-client'
require 'json'
require 'pry'

def req(html)
  response = RestClient.get(html)
  hash = JSON.parse(response)
end


def gets_films_hash(movie_hash,character)
  movie_hash["results"].find do |result|
    result["name"] == character
  end["films"]
end


def get_character_movies_from_api(character)
  #make the web request
  character_hash = req('http://www.swapi.co/api/people/')
  gets_films_hash(character_hash,character)

  # found_character_data = character_hash["results"].find {|result| result["name"]}
  # films_hash = found_character_data["films"]
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    movie_hash = req(film)
    movie_description(movie_hash)
  end
end

def movie_description(hash)
  puts "*"*30
  puts "Title: #{hash["title"]}"
  puts "Description: #{hash["opening_crawl"]}"
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
