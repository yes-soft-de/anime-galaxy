<?php

namespace App\Entity;

use App\Repository\AnimeRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

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
     * @ORM\Column(type="json")
     */
    private $categories = [];

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

    /**
     * @ORM\Column(type="string", length=50, nullable=true)
     */
    private $generalRating;

    /**
     * @ORM\Column(type="string", length=50, nullable=true)
     */
    private $ageGroup;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $posterImage;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $posterSpecialLink;

    /**
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(type="datetime")
     */
    private $createdAt;

    /**
     * @Gedmo\Timestampable(on="update")
     * @ORM\Column(type="datetime")
     */
    private $updatedAt;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $updatedBy;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $createdBy;

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

    public function getCategories(): array
    {
        return array_unique($this->categories);
    }

    public function setCategories(array $categories): self
    {
        $this->categories = $categories;

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

    public function getGeneralRating(): ?string
    {
        return $this->generalRating;
    }

    public function setGeneralRating(?string $generalRating): self
    {
        $this->generalRating = $generalRating;

        return $this;
    }

    public function getAgeGroup(): ?string
    {
        return $this->ageGroup;
    }

    public function setAgeGroup(?string $ageGroup): self
    {
        $this->ageGroup = $ageGroup;

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

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getUpdatedBy(): ?string
    {
        return $this->updatedBy;
    }

    public function setUpdatedBy(string $updatedBy): self
    {
        $this->updatedBy = $updatedBy;

        return $this;
    }

    public function getCreatedBy(): ?string
    {
        return $this->createdBy;
    }

    public function setCreatedBy(string $createdBy): self
    {
        $this->createdBy = $createdBy;

        return $this;
    }

}
