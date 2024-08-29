# Music Database Schema

This SQL script sets up a database for managing music-related data. It includes tables for listeners, content creators, songs, reviewers, and reviews. It also creates several views and stored procedures to interact with the data.

## Overview

1. **Database Creation**
   - Drops existing `MusicDataBase` if it exists and creates a new one.

2. **Table Definitions**
   - **Listener**: Stores user information for listeners.
   - **contentCreator**: Stores details of music content creators.
   - **Song**: Stores song details including title, type, and release date.
   - **Reviewer**: Stores reviewer details.
   - **Review**: Stores reviews for songs including review content and score.

3. **Data Insertion**
   - Inserts sample data into each table.

4. **Views**
   - `listenerView`: Shows listener names and details.
   - `contentCreatorView`: Shows content creator details.
   - `reviewAndReviewer`: Joins review data with reviewer and song information.

5. **Stored Procedures**
   - `findArtist`: Finds an artist by stage name.
   - `findPositiveReviewsToMakeMeFeelBetter`: Finds positive reviews for a specific song.
