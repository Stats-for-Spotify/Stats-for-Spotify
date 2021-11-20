# Stats for Spotify

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app to view a users personal Spotify stats through the use of the official Spotify API. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Music
- **Mobile:** App would be created for mobile devices but can *potentially* be made for use on a cpmputer as well.
- **Story:** Tells a Spotify user what their person stats are including but not limited to: most played tracks, most played artist, etc. .
- **Market:** Spotify Users
- **Habit:** This app can be used whenever the user wants to know their stats.
- **Scope:** First we want to provide a few basic stats that we find to be the most popular or most interesting for a Spotify user. There is potential for us to be able to add in extra stats depending on what the official Spotify API allows for and what user feedback we recieve.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Login through Spotify(includes Spotify authorization)
* #1 played song
* List of most played songs
* #1 played artist
    * Most songs by that arist
* List of most played artists
* Genres(pop edm rock)


**Optional Nice-to-have Stories**

* Total playback time for a user selected song
* least listened to favorited song
* Users most searched for query

### 2. Screen Archetypes

* Login Screen
   * Login through Spotify(includes Spotify authorization)
   * opens safari for authorization 
* Main Screen
    * #1 played song
    * List of most played songs
    * #1 played artist
        * Most songs by that arist
    * List of most played artists
    * Genres(pop edm rock)
   

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Login Screen
* Stats Screen


**Flow Navigation** (Screen to Screen)

* Force user to login via Spotify authentication -> Stats page


## Wireframes

![](https://i.imgur.com/yuQ5ZFp.jpg)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models

| Property | Type | Description |
| -------- | -------- | -------- |
| artist     | String     |Artist of a given song  
| song    | String     | Name of a given song 
| tPlayed | int| Time played for a given song
mPlayedSongs |Array | List of most played songs
mPlayedArtists | Array | List of most played artists
artist1 | String| #1 played artist
song1 | String | #1 played song
genre | String| #1 played genre
cover |File |cover photo of song
userName| String|users Spotify username


### Networking
Base URL: https://developer.spotify.com/documentation/web-api/reference/#/
| HTTP Verb | Endpoint | Description |
| -------- | -------- | -------- |
| GET| /me/top/artists | Users top artists
GET| /me/type/tracks | Users top songs
GET| /time_range | Time played
GET| /display_name | Users Spotify username
GET| /album/images | Cover photo for specific song
GET | /album/name | Name of song
GET | /album/artists | Artist of song
GET | /album/genres | Genre of specific song


