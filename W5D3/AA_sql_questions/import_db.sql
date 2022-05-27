PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
 id INTEGER PRIMARY KEY,
 fname TEXT NOT NULL,
 lname TEXT NOT NULL
);


CREATE TABLE questions(
 id INTEGER PRIMARY KEY,
 title TEXT NOT NULL, 
 body TEXT NOT NULL,
 associated_author INTEGER NOT NULL,
FOREIGN KEY (associated_author) REFERENCES users(id)

);


CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)

);


CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL, 
    parent_id INTEGER,
    body TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id)
);



CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users(fname, lname)
VALUES
    ('Jacob', 'Justice'),
    ('Wendy', 'Shi'),
    ('Mike', 'Madison'),
    ('Paulo', 'Bocanegra'),
    ('Danny', 'Wallace');

INSERT INTO
    questions(title, body, associated_author)
VALUES
    ('cake', 'Is the cake a lie?', (SELECT id FROM users WHERE fname = 'Danny' AND lname = 'Wallace')),
    ('Recursion', 'How does one recursion???', (SELECT id FROM users WHERE fname = 'Jacob' AND lname = 'Justice')),
    ('Test', 'Test questions', (SELECT id FROM users WHERE fname = 'Jacob' AND lname = 'Justice')),
    ('Dino', 'This isnt a question.', (SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Shi'));

INSERT INTO
    question_follows (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Jacob' AND lname = 'Justice'), (SELECT id FROM questions WHERE title = 'cake')),
    ((SELECT id FROM users WHERE fname = 'Danny' AND lname = 'Wallace'), (SELECT id FROM questions WHERE title = 'Dino')),
    ((SELECT id FROM users WHERE fname = 'Danny' AND lname = 'Wallace'), (SELECT id FROM questions WHERE title = 'Recursion')),
    ((SELECT id FROM users WHERE fname = 'Paulo' AND lname = 'Bocanegra'), (SELECT id FROM questions WHERE title = 'Recursion'));

INSERT INTO
    replies(user_id, question_id, parent_id, body)
VALUES
    ((SELECT id FROM users WHERE fname = 'Danny' AND lname = 'Wallace'), (SELECT id FROM questions WHERE title = 'Dino'), NULL, 'Red dino' ),
    ((SELECT id FROM users WHERE fname = 'Jacob' AND lname = 'Justice'), (SELECT id FROM questions WHERE title = 'Dino'), 1, 'Blue dino');


INSERT INTO
    question_likes (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Jacob' AND lname = 'Justice'), (SELECT id FROM questions WHERE title = 'cake')),
    ((SELECT id FROM users WHERE fname = 'Danny' AND lname = 'Wallace'), (SELECT id FROM questions WHERE title = 'cake')),
    ((SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Shi'), (SELECT id FROM questions WHERE title = 'cake'));


