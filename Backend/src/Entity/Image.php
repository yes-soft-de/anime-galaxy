<?php

namespace App\Entity;

use App\Repository\ImageRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ImageRepository::class)
 */
class Image
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $image;

    /**
     * @ORM\Column(type="integer")
     */
    private $animeID;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $specialLink;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(int $id): self
    {
        $this->id = $id;

        return $this;
    }
    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(string $image): self
    {
        $this->image = $image;

        return $this;
    }

    public function getAnimeID(): ?int
    {
        return $this->animeID;
    }

    public function setAnimeID(int $animeID): self
    {
        $this->animeID = $animeID;

        return $this;
    }

    public function getSpecialLink(): ?bool
    {
        return $this->specialLink;
    }

    public function setSpecialLink(?bool $specialLink): self
    {
        $this->specialLink = $specialLink;

        return $this;
    }
}
