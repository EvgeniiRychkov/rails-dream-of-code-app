# Question 1
# For each CodingClass, create a new Course record for that class in the Spring 2026 trimester
trimester = Trimester.find_by(year: '2026', term: 'Spring')
CodingClass.find_each do |coding_class|
  Course.create(coding_class: coding_class, trimester: trimester, max_enrollment: 25)
end

# Question 2
# Create a new student record and enroll the student in the Intro to Programming course for the Spring 2026 trimester.
# Find a mentor with no more than 2 students (enrollments) assigned and assign that mentor to your new student's enrollment.
student = Student.create(first_name: 'Evgenii', last_name: 'Rychkov', email: 'evgenii.rychkov87@gmail.com')
course = Course.includes(:trimester, :coding_class).find_by(trimester: trimester,
                                                            coding_class: { title: 'Intro to Programming' })
enrollment = Enrollment.create(student: student, course: course)

mentor = MentorEnrollmentAssignment
         .group(:mentor_id)
         .having('COUNT(mentor_id) <= 2')
         .first.mentor

MentorEnrollmentAssignment.create(mentor: mentor, enrollment: enrollment)

# Question 3
# My website for movie lovers. It provide a space for users to share reviews about movies they have watched.
# Users can add reviews, rate movies, and browse films.
#
# Regular users – can add reviews, rate movies, and browse films.
# Guests (unregistered users) – can only view the movie list and reviews.
#
# A user enters a movie title, rates it, and writes a review.
# A user browses the movie list and sorts it by title or average rating.
# A user reads reviews from other users.
# A user views their rated movies, edits, or deletes them.
