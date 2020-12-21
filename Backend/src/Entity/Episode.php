<?php

namespace App\Entity;

use App\Repository\EpisodeRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=EpisodeRepository::class)
 */
class Episode
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="integer")
     */
    private $animeID;

    /**
     * @ORM\Column(type="integer")
     */
    private $seasonNumber;

    /**
     * @ORM\Column(type="integer")
     */
    private $episodeNumber;

    /**
     * @ORM\Column(type="text")
     */
    private $description;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $image;

    /**
     * @ORM\Column(type="time", nullable=true)
     */
    private $duration;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $publishDate;

    /**
     * @ORM\Column(type="date")
     */
    private $createdAt;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $specialLink;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $categoyID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $posterImage;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $posterSpecialLink;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getSeasonNumber(): ?int
    {
        return $this->seasonNumber;
    }

    public function setSeasonNumber(int $seasonNumber): self
    {
        $this->seasonNumber = $seasonNumber;

        return $this;
    }

    public function getEpisodeNumber(): ?int
    {
        return $this->episodeNumber;
    }

    public function setEpisodeNumber(int $episodeNumber): self
    {
        $this->episodeNumber = $episodeNumber;

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

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(string $image): self
    {
        $this->image = $image;

        return $this;
    }

    public function getDuration(): ?\DateTimeInterface
    {
        return $this->duration;
    }

    public function setDuration($duration): self
    {
        $this->duration = new \DateTime($duration);

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

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(): self
    {
        $this->createdAt = new \DateTime('Now');

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

    public function getCategoyID(): ?string
    {
        return $this->categoyID;
    }

    public function setCategoyID(string $categoyID): self
    {
        $this->categoyID = $categoyID;

        return $this;
    }

    public function getPosterImage(): ?string
    {
        return $this->posterImage;
    }

    public function setPosterImage(?string $posterImage): self
    {
        $this->posterImage = $posterImage;

        return $this;
    }

    public function getPosterSpecialLink(): ?bool
    {
        return $this->posterSpecialLink;
    }

    public function setPosterSpecialLink(?bool $posterSpecialLink): self
    {
        $this->posterSpecialLink = $posterSpecialLink;

        return $this;
    }
}
