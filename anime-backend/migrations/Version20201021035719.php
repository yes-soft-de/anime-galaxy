<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201021035719 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE anime ADD description LONGTEXT NOT NULL');
        $this->addSql('ALTER TABLE episode ADD special_link TINYINT(1) DEFAULT NULL');
        $this->addSql('ALTER TABLE user_profile ADD location VARCHAR(255) DEFAULT NULL, CHANGE name user_name VARCHAR(255) NOT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE anime DROP description');
        $this->addSql('ALTER TABLE episode DROP special_link');
        $this->addSql('ALTER TABLE user_profile DROP location, CHANGE user_name name VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`');
    }
}
