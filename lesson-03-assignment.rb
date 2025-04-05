# 1. What tables do you need to add? Decide on table names and their associations
#    to each other and any existing tables/models.

# Tables: topics and lessons_topics
# Associations: Topics has many lessons_topics, lessons_topics belongs to topics
#               Lesson has many lessons_topics, lessons_topics belongs to lesson
#               Lesson has many topics through lessons_topics, topics has many lessons through lessons_topics

# 2. What columns are necessary for the associations you decided on?

# LessonTopics: lesson_id, topic_id

# 3. What other columns (if any) need to be included on the tables? What other data needs to be stored?

# Topics: title

# 4. Write out each table's name and column names with data types.

# Table name: topics
# Columns: title:string (required)
# Table name: lessons_topics
# Columns: lesson_id:integer (required), topic_id:integer (required)

# 5. Determine the generator command you'll need to create the migration file and run the command
#    to generate the empty migration file. Start with just the topics migration.
#    (Hint: your filename should be create_topics)

# rails g migration create_topics
