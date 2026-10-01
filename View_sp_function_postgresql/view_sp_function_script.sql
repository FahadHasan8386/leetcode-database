-- View containing tweets along with the user's name and email
CREATE OR REPLACE VIEW tweet_feed AS
SELECT
    u.name,
    t.content,
    u.email
FROM tweets t
INNER JOIN users u
    ON t.user_id = u.id;


-- Select all tweets from the tweet feed
SELECT *
FROM tweet_feed;


-- Get tweets created by a specific user
SELECT *
FROM tweet_feed tf
WHERE tf.name = 'Rahim';


-- View showing the total number of tweets created by each user
CREATE VIEW user_tweet_statistics AS
SELECT
    u.id AS user_id,
    u.name,
    COUNT(t.id) AS total_tweets
FROM users u
LEFT JOIN tweets t
    ON u.id = t.user_id
GROUP BY
    u.id,
    u.name;


-- Select all user tweet statistics
SELECT *
FROM user_tweet_statistics;


-- Q1: View containing basic user profile information
CREATE VIEW user_profiles AS
SELECT
    id AS user_id,
    name,
    email
FROM users;


-- Select all user profiles
SELECT *
FROM user_profiles;


-- Q2: View showing the total number of likes for each tweet
CREATE VIEW tweet_like_statistics AS
SELECT
    t.id AS tweet_id,
    t.content,
    COUNT(l.id) AS total_likes
FROM tweets t
INNER JOIN users u
    ON t.user_id = u.id
LEFT JOIN likes l
    ON t.id = l.tweet_id
GROUP BY
    t.id,
    t.content;


-- Select all tweet like statistics
SELECT *
FROM tweet_like_statistics;


-- Procedure to create a new tweet
CREATE OR REPLACE PROCEDURE create_tweet(
    tweet_id UUID,
    user_id UUID,
    tcontent TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tweets(id, content, user_id)
    VALUES(tweet_id, tcontent, user_id);
END;
$$;


-- Create a new tweet using the procedure
CALL create_tweet(
    'ae7448d1-8415-4868-99da-b0959739df45',
    '924b99ef-50c7-408f-bfec-a22f31961377',
    'our first sp'
);


-- Display the updated tweet feed
SELECT *
FROM tweet_feed;


-- Procedure to create a new follow relationship
CREATE OR REPLACE PROCEDURE create_follow(
    follow_id UUID,
    follower_id UUID,
    following_id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO follows(id, follower_id, following_id)
    VALUES(follow_id, follower_id, following_id);
END;
$$;


-- Create a new follow relationship using the procedure
CALL create_follow(
    'PUT-FOLLOW-UUID-HERE',
    'PUT-FOLLOWER-UUID-HERE',
    'PUT-FOLLOWING-UUID-HERE'
);


-- Display all follow relationships
SELECT *
FROM follows;


-- Procedure to delete an existing tweet
CREATE OR REPLACE PROCEDURE delete_tweet(
    tweet_id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM tweets
    WHERE id = tweet_id;
END;
$$;


-- Function that returns the total number of tweets created by a user
CREATE OR REPLACE FUNCTION get_total_tweet(
    p_user_id UUID
)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
DECLARE
    total BIGINT;
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM tweets
    WHERE user_id = p_user_id;

    RETURN total;
END;
$$;


-- Get the total number of tweets created by a specific user
SELECT get_total_tweet(
    '924b99ef-50c7-408f-bfec-a22f31961377'
);


-- Function that returns the total number of followers for a user
CREATE OR REPLACE FUNCTION get_follower_count(
    p_user_id UUID
)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM follows
        WHERE following_id = p_user_id
    );
END;
$$;


-- Get the total number of followers for a specific user
SELECT get_follower_count(
    '924b99ef-50c7-408f-bfec-a22f31961377'
);