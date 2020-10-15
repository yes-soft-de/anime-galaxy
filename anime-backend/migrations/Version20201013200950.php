<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201013200950 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE user_profile (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, image VARCHAR(255) DEFAULT NULL, story LONGTEXT DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(180) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) NOT NULL, UNIQUE INDEX UNIQ_8D93D649A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE rating_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, episode_id INT NOT NULL, rate_value INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, episode_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction_comment_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, comment_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction_comment (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, comment_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE episode (id INT AUTO_INCREMENT NOT NULL, anime_id INT NOT NULL, season_number INT NOT NULL, episode_number INT NOT NULL, description LONGTEXT NOT NULL, image VARCHAR(255) NOT NULL, duration TIME DEFAULT NULL, publish_date DATE DEFAULT NULL, created_at DATE NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE comment_episode (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, episode_id INT NOT NULL, comment LONGTEXT NOT NULL, spoiler_alert TINYINT(1) DEFAULT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE comment_episode');
        $this->addSql('DROP TABLE episode');
        $this->addSql('DROP TABLE interaction_comment');
        $this->addSql('DROP TABLE interaction_comment_episode');
        $this->addSql('DROP TABLE interaction_episode');
        $this->addSql('DROP TABLE rating_episode');
        $this->addSql('DROP TABLE user');
        $this->addSql('DROP TABLE user_profile');
    }
}
