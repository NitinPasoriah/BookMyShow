# BookMyShow Database Design Assessment

## Project Overview
This project involves designing a normalized relational database for a movie ticketing platform. The system allows users to view movie schedules for a specific theater across a 7-day window, including show timings and movie details.

## Entity Relationship Analysis

### Entities & Attributes
1. **Theater**: Represents the cinema location.
    - `theater_id` (PK): Unique identifier for the theater.
    - `name`: Name of the theater (e.g., PVR Nexus).
    - `location`: City or area.

2. **Movie**: Represents the films available for screening.
    - `movie_id` (PK): Unique identifier for the movie.
    - `title`: Title of the film (e.g., Dasara).
    - `certification`: Censorship rating (e.g., UA).
    - `language`: Primary language of the film.

3. **Screen**: Represents physical halls within a theater.
    - `screen_id` (PK): Unique identifier.
    - `theater_id` (FK): Links to the Theater table.
    - `screen_format`: Audio/Visual tech (e.g., 4K Atmos, Dolby 7.1).

4. **Show**: The mapping of a movie to a screen at a specific time.
    - `show_id` (PK): Unique identifier.
    - `screen_id` (FK): Links to the Screen table.
    - `movie_id` (FK): Links to the Movie table.
    - `show_date`: The date of the show.
    - `start_time`: The timing of the show.

## Normalization (1NF to BCNF)
- **1NF**: All table cells contain atomic values. No repeating groups (e.g., multiple timings are stored as separate rows in the `Shows` table).
- **2NF**: All non-key attributes are fully functionally dependent on the primary key.
- **3NF**: No transitive dependencies exist. For example, movie language depends on `movie_id`, not on `show_id`.
- **BCNF**: Every determinant in the tables is a candidate key. The design ensures no redundancy even if multiple movies run on the same screen.