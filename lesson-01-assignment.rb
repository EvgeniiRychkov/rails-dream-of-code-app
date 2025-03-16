# Task 1: Collect emails for students in the current Intro course
coding_class = CodingClass.find_by(title: 'Intro to Programming')
trimester = Trimester.find_by(year: '2025', term: 'Spring')
course = Course.find_by(coding_class: coding_class, trimester: trimester)
students_data = Enrollment.joins(:student)
                          .where(course: course)
                          .pluck('students.id', 'students.email')
                          .map { |id, email| { id: id, email: email } }

# Task 2: Email all mentors who have not assigned a final grade
coding_class = CodingClass.find_by(title: 'Intro to Programming')
trimester = Trimester.find_by(year: '2025', term: 'Spring')
course = Course.find_by(coding_class: coding_class, trimester: trimester)
mentors_data = Enrollment.joins(mentor_enrollment_assignments: :mentor)
                         .where(course: course, final_grade: nil)
                         .distinct
                         .pluck('mentors.id', 'mentors.email')
                         .map { |id, email| { id: id, email: email } }
