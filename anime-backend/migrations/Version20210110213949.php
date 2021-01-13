<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20210110213949 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE anime ADD created_at DATETIME NOT NULL, ADD updated_at DATETIME NOT NULL, ADD updated_by VARCHAR(255) DEFAULT NULL, ADD created_by VARCHAR(255) NOT NULL');
        $this->addSql('ALTER TABLE category ADD created_at DATETIME NOT NULL, ADD updated_at DATETIME NOT NULL, ADD updated_by VARCHAR(255) DEFAULT NULL, ADD created_by VARCHAR(255) NOT NULL');
        $this->addSql('ALTER TABLE episode ADD updated_at DATETIME NOT NULL, ADD created_by VARCHAR(255) NOT NULL, ADD updated_by VARCHAR(255) DEFAULT NULL, CHANGE created_at created_at DATETIME NOT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE anime DROP created_at, DROP updated_at, DROP updated_by, DROP created_by');
        $this->addSql('ALTER TABLE category DROP created_at, DROP updated_at, DROP updated_by, DROP created_by');
        $this->addSql('ALTER TABLE episode DROP updated_at, DROP created_by, DROP updated_by, CHANGE created_at created_at DATE NOT NULL');
    }
}
