<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200923104037 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE anime ADD creation_date DATE DEFAULT NULL');
        $this->addSql('ALTER TABLE comment ADD solar TINYINT(1) DEFAULT NULL, ADD creation_date DATE DEFAULT NULL');
        $this->addSql('ALTER TABLE inter_action ADD creation_date DATE DEFAULT NULL');
        $this->addSql('ALTER TABLE rating ADD creation_date DATE DEFAULT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE anime DROP creation_date');
        $this->addSql('ALTER TABLE comment DROP solar, DROP creation_date');
        $this->addSql('ALTER TABLE inter_action DROP creation_date');
        $this->addSql('ALTER TABLE rating DROP creation_date');
    }
}
