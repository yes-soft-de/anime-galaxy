<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201122233647 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE anime (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, main_image VARCHAR(255) NOT NULL, category_id INT NOT NULL, creation_date DATE DEFAULT NULL, special_link TINYINT(1) DEFAULT NULL, description LONGTEXT NOT NULL, publish_date DATE DEFAULT NULL, episodes_count INT DEFAULT NULL, trailer_video VARCHAR(500) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE category (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, description LONGTEXT NOT NULL, image VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE comment (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, anime_id INT NOT NULL, comment LONGTEXT NOT NULL, spoiler_alert TINYINT(1) DEFAULT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE comment_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, episode_id INT NOT NULL, comment LONGTEXT NOT NULL, spoiler_alert TINYINT(1) DEFAULT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE episode (id INT AUTO_INCREMENT NOT NULL, anime_id INT NOT NULL, season_number INT NOT NULL, episode_number INT NOT NULL, description LONGTEXT NOT NULL, image VARCHAR(255) NOT NULL, duration TIME DEFAULT NULL, publish_date DATE DEFAULT NULL, created_at DATE NOT NULL, special_link TINYINT(1) DEFAULT NULL, categoy_id VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE favourite (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, anime_id INT NOT NULL, category_id INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE follow (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, friend_id VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE grade (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, points INT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE image (id INT AUTO_INCREMENT NOT NULL, image VARCHAR(255) NOT NULL, anime_id INT NOT NULL, special_link TINYINT(1) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, anime_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction_comment (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, comment_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction_comment_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, comment_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, episode_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE rating (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, anime_id INT NOT NULL, rate_value INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE rating_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, episode_id INT NOT NULL, rate_value INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE setting_entity (id INT AUTO_INCREMENT NOT NULL, upload_sub_folder VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(180) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME DEFAULT NULL, UNIQUE INDEX UNIQ_8D93D649A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_profile (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, user_name VARCHAR(255) NOT NULL, image VARCHAR(255) DEFAULT NULL, story LONGTEXT DEFAULT NULL, location VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE anime');
        $this->addSql('DROP TABLE category');
        $this->addSql('DROP TABLE comment');
        $this->addSql('DROP TABLE comment_episode');
        $this->addSql('DROP TABLE episode');
        $this->addSql('DROP TABLE favourite');
        $this->addSql('DROP TABLE follow');
        $this->addSql('DROP TABLE grade');
        $this->addSql('DROP TABLE image');
        $this->addSql('DROP TABLE interaction');
        $this->addSql('DROP TABLE interaction_comment');
        $this->addSql('DROP TABLE interaction_comment_episode');
        $this->addSql('DROP TABLE interaction_episode');
        $this->addSql('DROP TABLE rating');
        $this->addSql('DROP TABLE rating_episode');
        $this->addSql('DROP TABLE setting_entity');
        $this->addSql('DROP TABLE user');
        $this->addSql('DROP TABLE user_profile');
    }
}
