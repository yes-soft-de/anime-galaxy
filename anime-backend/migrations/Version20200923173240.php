<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200923173240 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE interaction (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, anime_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('DROP TABLE inter_action');
        $this->addSql('ALTER TABLE anime ADD creation_date DATE DEFAULT NULL');
        $this->addSql('ALTER TABLE comment ADD spoiler_alert TINYINT(1) DEFAULT NULL, ADD creation_date DATE DEFAULT NULL');
        $this->addSql('ALTER TABLE favourite ADD category_id INT NOT NULL, ADD creation_date DATE DEFAULT NULL');
        $this->addSql('ALTER TABLE rating ADD creation_date DATE DEFAULT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE inter_action (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, anime_id INT NOT NULL, type INT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE `utf8_unicode_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('DROP TABLE interaction');
        $this->addSql('ALTER TABLE anime DROP creation_date');
        $this->addSql('ALTER TABLE comment DROP spoiler_alert, DROP creation_date');
        $this->addSql('ALTER TABLE favourite DROP category_id, DROP creation_date');
        $this->addSql('ALTER TABLE rating DROP creation_date');
    }
}
