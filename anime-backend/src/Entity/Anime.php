<?php

namespace App\Entity;

use App\Repository\AnimeRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=AnimeRepository::class)
 */
class Anime
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
    private $name;

    /**
     * @ORM\Column(type="string")
     */
    private $mainImage;

    /**
     * @ORM\Column(type="integer")
     */
    private $categoryID;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $creationDate;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $specialLink;

    /**
     * @ORM\Column(type="text")
     */
    private $description;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $publishDate;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $episodesCount;

    /**
     * @ORM\Column(type="string", length=500, nullable=true)
     */
    private $trailerVideo;

    /**
     * @ORM\Column(type="boolean", options={"default":0})
     */
    private $suggest = 0;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getMainImage(): ?string
    {
        return $this->mainImage;
    }

    public function setMainImage(string $mainImage): self
    {
        $this->mainImage = $mainImage;

        return $this;
    }

    public function getCategoryID(): ?int
    {
        return $this->categoryID;
    }

    public function setCategoryID(int $categoryID): self
    {
        $this->categoryID = $categoryID;

        return $this;
    }

     public function getCreationDate(): ?\DateTimeInterface
    {
        return $this->creationDate;
    }

    public function setCreationDate(): self
    {
        $this->creationDate = new \DateTime('Now');

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
    
    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getPublishDate()
    {
        return $this->publishDate;
    }

    public function setPublishDate( $publishDate): self
    {
        $this->publishDate = new \DateTime($publishDate);

        return $this;
    }

    public function getEpisodesCount(): ?int
    {
        return $this->episodesCount;
    }

    public function setEpisodesCount(?int $episodesCount): self
    {
        $this->episodesCount = $episodesCount;

        return $this;
    }

    public function getTrailerVideo(): ?string
    {
        return $this->trailerVideo;
    }

    public function setTrailerVideo(?string $trailerVideo): self
    {
        $this->trailerVideo = $trailerVideo;

        return $this;
    }

    public function getSuggest(): ?bool
    {
        return $this->suggest;
    }

    public function setSuggest(bool $suggest): self
    {
        $this->suggest = $suggest;

        return $this;
    }

}
