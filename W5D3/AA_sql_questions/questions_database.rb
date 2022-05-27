require 'sqlite3'
require 'singleton'
require 'byebug'


class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

####################### User starts ######################

class User
    attr_accessor :id, :fname, :lname

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']

    end

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map{ |datum| User.new(datum) }
    end

    def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname)
            INSERT INTO
                users(fname, lname)
            VALUES
                (?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
    end


    def self.find_by_name(fname, lname)
        user = {fname: fname, lname: lname}

        user_to_save = QuestionsDatabase.instance.execute(<<-SQL, user)
            SELECT *
            FROM users
            WHERE users.fname = :fname AND users.lname = :lname
        SQL
        
        if user_to_save.empty?
            return nil 
        else
            User.new(user_to_save[0])
        end

    end

    def self.find_by_id(id)
        user = {id: id}

        user_to_save = QuestionsDatabase.instance.execute(<<-SQL, user)
            SELECT *
            FROM users
            WHERE users.id = :id
        SQL
        
        if user_to_save.empty?
            return nil 
        else
            User.new(user_to_save[0])
        end

    end

    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_user_id(@id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(@id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(@id)
    end

end

####################### Question starts ######################

class Question
    attr_accessor :id, :title, :body, :associated_author

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @associated_author = options['associated_author']

    end

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map{ |datum| Question.new(datum) }
    end

    def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.associated_author)
            INSERT INTO
                users(title, body, associated_author)
            VALUES
                (?, ?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
    end


    def self.find_by_title(title)
        question = {title: title}

        question_to_save = QuestionsDatabase.instance.execute(<<-SQL, question)
            SELECT *
            FROM questions
            WHERE questions.title = :title
        SQL
        
        if question_to_save.empty?
            return nil 
        else
            Question.new(question_to_save[0])
        end

    end

    def self.find_by_id(id)
        question = {id: id}

        question_to_save = QuestionsDatabase.instance.execute(<<-SQL, question)
            SELECT *
            FROM questions
            WHERE questions.id = :id
        SQL
        
        if question_to_save.empty?
            return nil 
        else
            Question.new(question_to_save[0])
        end

    end

    def self.find_by_author_id(author_id)
        author = {author_id: author_id}

        author_to_save = QuestionsDatabase.instance.execute(<<-SQL, author )
            SELECT *
            FROM questions
            WHERE questions.associated_author = :author_id
        SQL

        question_results = []

        if author_to_save.empty?
            return nil 
        else
            author_to_save.each do |q|
                question_results << Question.new(q)
            end
        end

        return question_results
    end

    def author
        User.find_by_id(@associated_author)
    end

    def replies
        Reply.find_by_question_id(@id)
    end

    def followers
        QuestionFollow.followers_for_question_id(@id)
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def likers
        QuestionLike.likers_for_question_id(@id)
    end

    def num_likes
        QuestionLike.num_likes_for_questions_id(@id)
    end

end




####################### QuestionFollow starts ######################


class QuestionFollow
    attr_accessor :id, :user_id, :question_id

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']

    end

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map{ |datum| QuestionFollow.new(datum) }
    end

    def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.user_id, self.question_id)
            INSERT INTO
                question_follows(user_id, question_id)
            VALUES
                (?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
    end

    def self.find_by_id(id)
        follow = {id: id}

        follow_to_save = QuestionsDatabase.instance.execute(<<-SQL, follow)
            SELECT *
            FROM question_follows
            WHERE question_follows.id = :id
        SQL
        
        if follow_to_save.empty?
            return nil 
        else
            QuestionFollow.new(follow_to_save[0])
        end
    end

    def self.followers_for_question_id(question_id)
        question = {question_id: question_id}

        users_found = QuestionsDatabase.instance.execute(<<-SQL, question)
            SELECT
                users.id, users.fname, users.lname
            FROM
                users
            JOIN
                question_follows
            ON
                users.id = question_follows.user_id
            WHERE
                question_follows.question_id = :question_id
        SQL

        result_users = []
        if users_found.empty?
            return nil
        else
            users_found.each do |u|
                result_users << User.new(u)
            end
        end
        return result_users
    end

    def self.followed_questions_for_user_id(user_id)
        user = {user_id: user_id}

        questions_found = QuestionsDatabase.instance.execute(<<-SQL, user)
            SELECT
                questions.id, questions.title, questions.body, questions.associated_author
            FROM
                questions
            JOIN
                question_follows
            ON
                questions.id = question_follows.question_id
            WHERE
                question_follows.user_id = :user_id
        SQL

        result_questions = []
        if questions_found.empty?
            return nil
        else
            questions_found.each do |q|
                result_questions << Question.new(q)
            end
        end
        return result_questions
    end

    def self.most_followed_questions(n)

        questions_found = QuestionsDatabase.instance.execute(<<-SQL, n )
            SELECT
                question_id
            FROM
                questions
            JOIN
                question_follows
            ON
                questions.id = question_follows.question_id
            GROUP BY question_id
            ORDER BY COUNT(*) DESC
            LIMIT (?)

        SQL

        result_questions = []
        if questions_found.empty?
            return nil
        else
            questions_found.each do |hash|
                result_questions<< Question.find_by_id(hash['question_id'])
            end
        end
        return result_questions
    end

end

####################### QuestionLike starts ######################

class QuestionLike
    attr_accessor :id, :user_id, :question_id

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']

    end

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map{ |datum| QuestionLike.new(datum) }
    end

    def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.user_id, self.question_id)
            INSERT INTO
                question_likes(user_id, question_id)
            VALUES
                (?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
    end

    def self.find_by_id(id)
        like = {id: id}

        like_to_save = QuestionsDatabase.instance.execute(<<-SQL, like)
            SELECT *
            FROM question_likes
            WHERE question_likes.id = :id
        SQL
        
        if like_to_save.empty?
            return nil 
        else
            QuestionLike.new(like_to_save[0])
        end

    end

    def self.likers_for_question_id(question_id)
        question = {question_id: question_id}

        users_found = QuestionsDatabase.instance.execute(<<-SQL, question)
            SELECT
                users.id, users.fname, users.lname
            FROM
                users
            JOIN
                question_likes
            ON
                users.id = question_likes.user_id
            WHERE
                question_likes.question_id = :question_id
        SQL

        result_users = []
        if users_found.empty?
            return nil
        else
            users_found.each do |u|
                result_users << User.new(u)
            end
        end
        return result_users
    end

    def self.num_likes_for_questions_id(question_id)
        question = {question_id: question_id}

        num = QuestionsDatabase.instance.execute(<<-SQL, question)
            SELECT
                COUNT(*) AS count_like
            FROM
                question_likes
            GROUP BY
                question_id
            HAVING
                question_id = :question_id
        SQL

        return num[0]['count_like']
    end

    def self.liked_questions_for_user_id(user_id)
        user = {user_id: user_id}

        questions_found = QuestionsDatabase.instance.execute(<<-SQL, user)
            SELECT
                questions.id, questions.title, questions.body, questions.associated_author
            FROM
                questions
            JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                question_likes.user_id = :user_id
        SQL

        result_questions = []
        if questions_found.empty?
            return nil
        else
            questions_found.each do |q|
                result_questions << Question.new(q)
            end
        end
        return result_questions

    end


end

####################### Reply starts ######################

class Reply
    attr_accessor :id, :user_id, :question_id, :parent_id, :body

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
        @parent_id = options['parent_id']
        @body = options['body']

    end

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map{ |datum| Reply.new(datum) }
    end

    def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.user_id, self.question_id, self.parent_id, self.body)
            INSERT INTO
                replies(user_id, question_id, parent_id, body)
            VALUES
                (?, ?, ?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
    end

    def self.find_by_id(id)
        reply = {id: id}

        reply_to_save = QuestionsDatabase.instance.execute(<<-SQL, reply)
            SELECT *
            FROM replies
            WHERE replies.id = :id
        SQL
        
        if reply_to_save.empty?
            return nil 
        else
            Reply.new(reply_to_save[0])
        end

    end


    def self.find_by_user_id(user_id)
        user = {user_id: user_id}

        reply_to_save = QuestionsDatabase.instance.execute(<<-SQL, user )
            SELECT *
            FROM replies
            WHERE replies.user_id = :user_id
        SQL

        reply_results = []

        if reply_to_save.empty?
            return nil 
        else
            reply_to_save.each do |r|
                reply_results << Reply.new(r)
            end
        end

        return reply_results
    end

    def self.find_by_question_id(question_id)
        question = {question_id: question_id}

        reply_to_save = QuestionsDatabase.instance.execute(<<-SQL, question )
            SELECT *
            FROM replies
            WHERE replies.question_id = :question_id
        SQL

        reply_results = []

        if reply_to_save.empty?
            return nil 
        else
            reply_to_save.each do |r|
                reply_results << Reply.new(r)
            end
        end

        return reply_results
    end

    def author
        User.find_by_id(@user_id)
    end

    def question
        Question.find_by_id(@question_id)
    end

    def parent_reply
        Reply.find_by_id(@parent_id)
    end

    def child_reply
        question.replies.each do |reply|
            return reply if reply.parent_id == @id
        end
    end


end